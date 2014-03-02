package flashdriver.socket;


import java.io.*;
import java.net.ServerSocket;
import java.net.Socket;

public class FlashDriverConnection {

    Socket serverSocket;

    public void connect(int port) throws IOException {
        ServerSocket server = new ServerSocket(54081);
        serverSocket = server.accept();
        System.out.println("Connection received from " + serverSocket.getInetAddress().getHostName());
    }

    public void close() throws IOException {
        serverSocket.close();
    }

    public String sendRequest(String request) throws IOException {

        PrintWriter writer = new PrintWriter(new OutputStreamWriter(serverSocket.getOutputStream()), true);

        System.out.println("client>>> " + request);
        writer.println(request);
        writer.flush();

        BufferedReader reader = new BufferedReader(new InputStreamReader(serverSocket.getInputStream()));

        System.out.println("waiting for response...");
        while (serverSocket.isConnected()) {
            String data  = reader.readLine();

            data = data.substring(2); //trimming first two characters, strange

            System.out.println("> " + data);
            return data;

        }
        return "TODO";
    }

}
