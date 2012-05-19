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
    public static void main() {


        Server server = new Server();

        try {
            File keyStoreFile = new File("config/keystore");
            if (keyStoreFile.exists()) {
                SslSelectChannelConnector sslConnector = new SslSelectChannelConnector();
                sslConnector.setPort(8080);
                sslConnector.setKeystore(keyStoreFile.getPath());
                sslConnector.setPassword("P@$$w0rd");
                sslConnector.setKeyPassword("Thilina");
                server.addConnector(sslConnector);
                logger.info("Create SSL connection.");
            }

        } catch (Exception ex) {

            logger.error("Error creating SSL connection : " + ex);
        }

        try {

            WebAppContext context = new WebAppContext();
            context.setDescriptor("./webapp/WEB-INF/web.xml");
            context.setResourceBase("./webapp");
            context.setContextPath("/");
            context.setParentLoaderPriority(true);
            server.setHandler(context);

            server.start();
            server.join();
        } catch (Exception ex) {
            logger.info("Error on Jetty : " + ex);
        }
    }
}