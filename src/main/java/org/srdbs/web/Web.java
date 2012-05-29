package org.srdbs.web;

import org.apache.log4j.Logger;
import org.eclipse.jetty.server.Server;
import org.eclipse.jetty.server.ssl.SslSelectChannelConnector;
import org.eclipse.jetty.webapp.WebAppContext;
import org.srdbs.core.Global;

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
     * This is the runWebDashboard method of the web application
     */
    public static void runWebDashboard() {

        Server server = new Server();
        String keystrokePath = Global.systemHome + Global.fs + "config"
                + Global.fs + "keystore";
        logger.info("Initializing SSL certificates.");

        try {
            File keyStoreFile = new File(keystrokePath);
            if (keyStoreFile.exists()) {
                SslSelectChannelConnector sslConnector = new SslSelectChannelConnector();
                sslConnector.setPort(Global.webPort);
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
            String webXmlpath = Global.systemHome + Global.fs +
                    "webapp" + Global.fs + "WEB-INF" + Global.fs + "web.xml";
            logger.info("Web XML path : " + webXmlpath);
            context.setDescriptor(webXmlpath);
            String webAppPath = Global.systemHome + Global.fs + "webapp";
            context.setResourceBase(webAppPath);
            context.setContextPath("/");
            context.setParentLoaderPriority(true);
            server.setHandler(context);

            server.start();
            logger.info("Start the web dashboard.");
            server.join();
        } catch (Exception ex) {
            logger.error("Error on Jetty : " + ex);
        }
    }
}