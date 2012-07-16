package org.srdbs.scheduler;

/**
 * Secure and Redundant Data Backup System.
 * User: Thilina Piyasundara
 * Date: 7/5/12
 * Time: 12:49 PM
 * For more details visit : http://www.thilina.org
 */
public class Schedule {

    private String location;
    private int frequency;
    private int StartHour;
    private int StartMin;
    private int compress;
    private int encrypt;

    public int getEncrypt() {
        return encrypt;
    }

    public void setEncrypt(int encrypt) {
        this.encrypt = encrypt;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public int getFrequency() {
        return frequency;
    }

    public void setFrequency(int frequency) {
        this.frequency = frequency;
    }

    public int getStartHour() {
        return StartHour;
    }

    public void setStartHour(int startHour) {
        StartHour = startHour;
    }

    public int getStartMin() {
        return StartMin;
    }

    public void setStartMin(int startMin) {
        StartMin = startMin;
    }

    public int getCompress() {
        return compress;
    }

    public void setCompress(int compress) {
        this.compress = compress;
    }
}
