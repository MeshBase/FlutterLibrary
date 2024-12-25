package com.mesh.mesh;


import org.junit.Test;
import org.junit.jupiter.api.Assertions;

public class FileDataTest {

    @Test
    public void testMarshalAndUnmarshal() {
        String fileType = "jpg";
        byte[] rawData = {1, 2, 3, 4, 5}; // Example binary data

        FileData originalData = new FileData(fileType, rawData);

        byte[] binaryData = FileData.marshal(originalData);
        Assertions.assertNotNull(binaryData);
        Assertions.assertTrue(binaryData.length > 0);

        FileData unmarshalledData = FileData.demarshal(binaryData);
        Assertions.assertNotNull(unmarshalledData);

        Assertions.assertEquals(originalData, unmarshalledData);
    }

    @Test
    public void testEmptyRawData() {
        String fileType = "txt";
        byte[] rawData = new byte[0];

        FileData originalData = new FileData(fileType, rawData);

        byte[] binaryData = FileData.marshal(originalData);
        Assertions.assertNotNull(binaryData);

        FileData unmarshalledData = FileData.demarshal(binaryData);

        Assertions.assertEquals(originalData, unmarshalledData);
    }

}
 