package buffer;

import java.io.IOException;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;

public class Buffer
{
    private File file;
    private BufferedWriter writer;
    private String buffer;
    private int bufferSize = 256;

    public Buffer(String fileName)
    throws IOException
    {
        file = new File(fileName);
        writer = new BufferedWriter(new FileWriter(file.getAbsoluteFile()));
        buffer = "";
    }

    public int getBufferSize()
    {
        return bufferSize;
    }

    public int setBufferSize(int newSize)
    {
        bufferSize = newSize;
        return getBufferSize();
    }

    public void write(String data)
    throws IOException
    {
        buffer += data;
        if (buffer.length() >= bufferSize) {
            writer.write(buffer);
            buffer = "";
        }
    }

    public void close()
    throws IOException
    {
        writer.write(buffer);
        writer.close();
    }

}
