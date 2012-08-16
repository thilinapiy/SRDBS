package org.srdbs.messenger;

import org.apache.activemq.ActiveMQConnectionFactory;
import org.apache.log4j.Logger;

import javax.jms.*;
import java.util.UUID;

/**
 * Secure and Redundant Data Backup System.
 * User: Thilina Piyasundara
 * Date: 7/13/12
 * Time: 8:34 PM
 * For more details visit : http://www.thilina.org
 */
public class Sender implements MessageListener {

    public static Logger logger = Logger.getLogger("systemsLog");

    private static String brokerUrl;
    private String requestQueue = "requests";

    Connection connection;
    private Session session;
    private MessageProducer producer;
    private MessageConsumer consumer;

    private Destination tempDest;

    public void start() throws JMSException {
        ActiveMQConnectionFactory connectionFactory = new ActiveMQConnectionFactory(brokerUrl);
        connection = connectionFactory.createConnection();
        connection.start();
        session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);
        Destination adminQueue = session.createQueue(requestQueue);

        producer = session.createProducer(adminQueue);
        producer.setDeliveryMode(DeliveryMode.NON_PERSISTENT);

        tempDest = session.createTemporaryQueue();
        consumer = session.createConsumer(tempDest);

        consumer.setMessageListener(this);
    }

    public void stop() throws JMSException {
        producer.close();
        consumer.close();
        session.close();
        connection.close();
    }

    public void request(String request) throws JMSException {
        logger.info("Sending: " + request);
        TextMessage txtMessage = session.createTextMessage();
        txtMessage.setText(request);

        txtMessage.setJMSReplyTo(tempDest);

        String correlationId = UUID.randomUUID().toString();
        txtMessage.setJMSCorrelationID(correlationId);
        this.producer.send(txtMessage);
    }

    public void onMessage(Message message) {
        try {
            logger.info("Received response : "
                    + ((TextMessage) message).getText());
        } catch (JMSException e) {
            logger.error("Error on received message : " + e);
        }
    }

    public static void sendMessage(String ip, int port, String message) throws Exception {

        brokerUrl = "tcp://" + ip + ":" + String.valueOf(port);

        Sender sender = new Sender();
        sender.start();
        sender.request(message);
        Thread.sleep(6000); //wait for replies
        sender.stop();
    }
}
