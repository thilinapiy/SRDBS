package org.srdbs.web;

import org.apache.log4j.Logger;
import org.eclipse.jetty.server.Server;
import org.eclipse.jetty.server.ssl.SslSelectChannelConnector;
import org.eclipse.jetty.webapp.WebAppContext;

import java.io.File;

/**
 * This will create the web application.
 *
 * @author Thilina Piyasundara
 * @version 0.1
 */
public class Web {

    public static Logger logger = Logger.getLogger("systemsLog");

    /**
     * This is the main method of the web application
     */
    public static void main(String homePath, String fs) {


        Server server = new Server();
        String keystrokePath = homePath + fs + "config" + fs + "keystore";
        try {
            File keyStoreFile = new File(keystrokePath);
            if (keyStoreFile.exists()) {
                SslSelectChannelConnector sslConnector = new SslSelectChannelConnector();
                sslConnector.setPort(8080);
                sslConnector.setKeystore(keyStoreFile.getPath());
                sslConnector.setPassword("P@$$w0rd");
                sslConnector.setKeyPassword("Thilina");
                server.addConnector(sslConnector);
                logger.info("Create SSL connection.");
            } else {
                logger.error("No \"keystroke\" file in : " + keystrokePath);
                System.exit(-1);
            }

        } catch (Exception ex) {

            logger.error("Error creating SSL connection : " + ex);
            System.exit(-1);
        }

        try {

            WebAppContext context = new WebAppContext();
            context.setDescriptor(homePath + "/webapp/WEB-INF/web.xml");
            context.setResourceBase(homePath + "/webapp");
            context.setContextPath("/");
            context.setParentLoaderPriority(true);
            server.setHandler(context);

            server.start();
            server.join();
        } catch (Exception ex) {
            logger.error("Error on Jetty : " + ex);
        }
    }
}