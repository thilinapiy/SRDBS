/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.srdbs.split;

import java.io.File;

/**
 * @author chana
 */
public class MYSpFile {

    private long spid;
    private long fid;
    private String name;
    private String hash;
    private String cDate;
    private long size;
    private File file;
    private int cloudId;
    private int rcloudId;


    public File getFile() {
        return file;
    }

    public void setFile(File file) {
        this.file = file;
    }

    public long getId() {
        return spid;
    }

    public void setId(long spid) {
        this.spid = spid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getHash() {
        return hash;
    }

    public void setHash(String hash) {
        this.hash = hash;
    }

    public String getcDate() {
        return cDate;
    }

    public void setcDate(String cDate) {
        this.cDate = cDate;
    }

    public long getSize() {
        return size;
    }

    public void setSize(long size) {
        this.size = size;
    }

    public int getCloud() {
        return cloudId;
    }

    public void setCloud(int cloudId) {
        this.cloudId = cloudId;
    }

    public int getRCloud() {
        return rcloudId;
    }

    public void setRcloud(int RcloudID) {
        this.rcloudId = RcloudID;
    }

    public long getFid() {
        return fid;
    }

    public void setFid(long fid) {
        this.fid = fid;
    }
}
