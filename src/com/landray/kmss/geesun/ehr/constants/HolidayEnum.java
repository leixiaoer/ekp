package com.landray.kmss.geesun.ehr.constants;

public enum HolidayEnum {
    //枚举
    LEAVE_YEAR("年假"),//1
    LEAVE_BUSINESS("事假"),//12
    LEAVE_SICK("病假"),//3
    LEAVE_MATERNITY("生育产假"),//4
    LEAVE_LACTATION("哺乳假"),//14
    LEAVE_MARRY("婚假"),//6
    LEAVE_BEREAVMENT("丧假"),//7
    LEAVE_WORKINJURY("工伤假"),//8
    LEAVE_WELFARE("福利假"),//9
    LEAVE_MATERNITYEX("产检假"),//15
    LEAVE_NURSING("陪护假"),//11
    LEAVE_ISLOAD("隔离事假");//16


    private String typeValue;

    private HolidayEnum(String holidayValue) {
        typeValue = holidayValue;
    }

    @Override
    public String toString() {
        return this.typeValue;
    }

    public static HolidayEnum getHolidayValue(int num) {
        switch (num) {
            case 1:
                return HolidayEnum.LEAVE_YEAR;
            case 3:
                return HolidayEnum.LEAVE_SICK;
            case 4:
                return HolidayEnum.LEAVE_MATERNITY;
            case 6:
                return HolidayEnum.LEAVE_MARRY;
            case 7:
                return HolidayEnum.LEAVE_BEREAVMENT;
            case 8:
                return HolidayEnum.LEAVE_WORKINJURY;
            case 9:
                return HolidayEnum.LEAVE_WELFARE;
            case 11:
                return HolidayEnum.LEAVE_NURSING;
            case 12:
                return HolidayEnum.LEAVE_BUSINESS;
            case 14:
                return HolidayEnum.LEAVE_LACTATION;
            case 15:
                return HolidayEnum.LEAVE_MATERNITYEX;
            case 16:
                return HolidayEnum.LEAVE_ISLOAD;
            default:
                System.out.println("wrong number!");
                return null;
        }
    }

}
