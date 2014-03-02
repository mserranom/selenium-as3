package flashdriver.socket;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.ObjectOutputStream;
import java.net.ServerSocket;
import java.net.Socket;

public class PolicyServer {
    public static final String POLICY_XML =
            "<?xml version=\"1.0\"?>"
                    + "<cross-domain-policy>"
                    + "<allow-access-from domain=\"*\" to-ports=\"*\" />"
                    + "</cross-domain-policy>";

    public void start() {
        new Thread(new Runnable() {

            Socket serverSocket;
            private ObjectOutputStream out;

            @Override
            public void run() {
                System.out.println("Hello from a thread!");
                ServerSocket server = null;
                try {
                    server = new ServerSocket(55000);
                    serverSocket = server.accept();
                    System.out.println("Policy Server: connection received from " + serverSocket.getInetAddress().getHostName());

                    BufferedReader reader = new BufferedReader(new InputStreamReader(serverSocket.getInputStream()));

                    while (serverSocket.isConnected()) {
                        String data = reader.readLine();

                        if (data != null) {
                            System.out.println(">>>> " + data);
                            serverSocket.getOutputStream().write(PolicyServer.POLICY_XML.getBytes());
                            serverSocket.getOutputStream().write(0x00); //write required endbit
                            serverSocket.getOutputStream().flush();
                            return;
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }

            }
        }).start();

    }
}