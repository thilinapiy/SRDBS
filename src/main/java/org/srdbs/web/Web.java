package org.srdbs.web;

import org.eclipse.jetty.server.Server;
import org.eclipse.jetty.webapp.WebAppContext;

/**
 * This will create the web application.
 *
 * @version 0.1
 * @author Thilina Piyasundara
 */
public class Web {

    /**
     * This is the main method of the web application
     *
     * @throws Exception
     */
    public static void main() throws Exception {
        Server server = new Server(8080);

        System.out.println("Starting jetty.");
        WebAppContext context = new WebAppContext();
        context.setDescriptor("./webapp/WEB-INF/web.xml");
        context.setResourceBase("./webapp");
        context.setContextPath("/");
        context.setParentLoaderPriority(true);

        server.setHandler(context);

        server.start();
        server.join();
    }
}