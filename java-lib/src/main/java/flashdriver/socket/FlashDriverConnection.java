package flashdriver.socket;


import flashdriver.exceptions.FlashDriverConnectionException;
import flashdriver.exceptions.FlashDriverInternalException;

import java.io.*;
import java.net.ServerSocket;
import java.net.Socket;

public class FlashDriverConnection {

    private Socket serverSocket;

    private int connectionTimeout;

    public void connect(int port) {
        try {
            ServerSocket server = new ServerSocket(port);
            server.setSoTimeout(connectionTimeout);
            serverSocket = server.accept();
            System.out.println("Connection received from " + serverSocket.getInetAddress().getHostName());
        } catch (Exception e) {
            close();
            throw new FlashDriverConnectionException("unable to create socket: " + e.getMessage());
        }
    }

    public void close() {
        try {
            if(serverSocket != null) {
                serverSocket.close();
            }
        } catch (Exception e) {
            throw new FlashDriverConnectionException("unable to close socket: " + e.getMessage());
        }
    }

    public void setConnectionTimeout(int value) {
        this.connectionTimeout = value;
    }

    public String sendRequest(String request) {

        PrintWriter writer = null;
        try {
            writer = new PrintWriter(new OutputStreamWriter(serverSocket.getOutputStream()), true);
        } catch (IOException e) {
            throw new FlashDriverConnectionException("unable to create output stream writer: " + e.getMessage());
        }

        System.out.println("client>>> " + request);
        writer.println(request);
        writer.flush();

        BufferedReader reader = null;
        try {
            reader = new BufferedReader(new InputStreamReader(serverSocket.getInputStream()));
        } catch (IOException e) {
            throw new FlashDriverConnectionException("unable to create input stream writer: " + e.getMessage());
        }

        System.out.println("waiting for response...");

        while (serverSocket.isConnected()) {

            String data  = null;
            try {
                data = reader.readLine();
            } catch (IOException e) {
                throw new FlashDriverConnectionException("unable to read input stream: " + e.getMessage());
            }

            data = data.substring(2); //trimming first two characters, strange

            System.out.println("> " + data);
            return data;

        }

        throw new FlashDriverInternalException("socket disconnected in an unexpected way");
    }

}
