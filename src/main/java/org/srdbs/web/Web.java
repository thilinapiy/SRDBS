package org.srdbs.web;

import org.eclipse.jetty.server.Server;
import org.eclipse.jetty.webapp.WebAppContext;

/**
 * This will create the web application.
 *
 * @author Thilina Piyasundara
 * @version 0.1
 */
public class Web {

    /**
     * This is the main method of the web application
     *
     * @throws Exception Will ignore exceptions
     */
    public static void main() throws Exception {
        Server server = new Server(8080);

        System.out.println("Starting web server.");
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