package com.mesh.mesh;

import java.nio.ByteBuffer;
import java.nio.charset.StandardCharsets;
import java.util.Arrays;

public class FileData {

    private String fileType; //if empty, its a string
    private byte[] rawData;


    public FileData(String fileType, byte[] rawData) {
        this.fileType = fileType;
        this.rawData = rawData;
    }

    public static byte[] marshal(FileData fileData) {
        byte[] fileTypeBytes = fileData.getFileType().getBytes(StandardCharsets.UTF_8);
        byte[] rawData = fileData.getRawData();

        ByteBuffer buffer = ByteBuffer.allocate(4 + fileTypeBytes.length + rawData.length);
        buffer.putInt(fileTypeBytes.length);
        buffer.put(fileTypeBytes);
        buffer.put(rawData);

        return buffer.array();
    }

    public static FileData demarshal(byte[] binaryData) {
        ByteBuffer buffer = ByteBuffer.wrap(binaryData);

        int fileTypeLength = buffer.getInt();
        byte[] fileTypeBytes = new byte[fileTypeLength];
        buffer.get(fileTypeBytes);

        byte[] rawData = new byte[buffer.remaining()];
        buffer.get(rawData);

        String fileType = new String(fileTypeBytes, StandardCharsets.UTF_8);
        return new FileData(fileType, rawData);
    }

    public boolean isString() {
        return fileType.isEmpty();
    }

    public String getFileType() {
        return fileType;
    }

    public void setFileType(String fileType) {
        this.fileType = fileType;
    }

    public byte[] getRawData() {
        return rawData;
    }

    public void setRawData(byte[] rawData) {
        this.rawData = rawData;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        FileData fileData = (FileData) obj;
        return fileType.equals(fileData.fileType) && Arrays.equals(rawData, fileData.rawData);
    }
}

