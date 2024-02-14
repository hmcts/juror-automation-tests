package cucumber.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAdjusters;
import java.util.Calendar;
import java.util.Date;
import java.util.Properties;

import org.apache.log4j.Logger;

import cucumber.pageObjects.SuspendDelete;

public class DateManipulator {
	private static Logger log = Logger.getLogger(DateManipulator.class);

	//https://stackoverflow.com/questions/24177516/get-first-next-monday-after-certain-date
	private static Boolean checkDate_isMonday(LocalDate ld) {
		log.info("Going to check whether =>"+ld+"<= is a Monday");
		return ld.getDayOfWeek().toString() == "MONDAY";
	}
	
	private static String returnWorkingDay_fromNextMondays(Integer mondays) {
		LocalDate ld = LocalDate.now();
		log.info("Current Date =>"+ld);
		
		if (!checkDate_isMonday(ld)) {
			ld = ld.with(TemporalAdjusters.next(DayOfWeek.MONDAY));
			log.info("Current date was not a Monday, I have now adjusted the logic to begin from Monday the =>" + ld);
		} else if (checkDate_isMonday(ld) && mondays == 1) {
			ld = ld.with(TemporalAdjusters.next(DayOfWeek.FRIDAY));
			log.info("Current date was Monday and 1 Monday's time was requested" +
					", I have now adjusted the date to the Friday of this week =>" + ld);
			return ld.toString();
		}

		log.info("Next Monday =>"+ld);
		ld = ld.plusWeeks(mondays-1);
		log.info("Next =>"+mondays+"<= mondays monday =>"+ld);
		return ld.toString();
	}

	public static String processString(String columnValue) {
		String partText = null;
		if (columnValue.contains("mondays time")) {
			partText = returnWorkingDay_fromNextMondays(
						Integer.parseInt(columnValue.split(" mondays time")[0])
					);
			if (!partText.contains(":"))
				partText += " 00:00:00";
		}
		return partText;
	}
	
	/** 
	 * Do this properly TODO
	 * @param columnValue
	 * @param time
	 * @return
	 */
	public static String processString(String columnValue, Boolean time) {
		if (time)
			return processString(columnValue);
		return processString(columnValue).replace(" 00:00:00", "");
	}
	
	private static Boolean amIAWeekDay(String day) {
		if (day.equalsIgnoreCase("saturday") || day.equalsIgnoreCase("sunday"))
			return false;
		return true;
	}
	
	/**
	 * Unsure on best implementation, looping for now
	 * @param workingDays
	 * @return
	 */
	public static String addWorkingDaysToCurrentDate(Integer workingDays) {
		LocalDate ld = LocalDate.now();
		Integer baseInt = 1;
		if (workingDays < 0)
			baseInt = -1;
			workingDays = workingDays * -1;
		while (true) {
			if (workingDays == 0)
				break;
			ld = ld.plusDays(baseInt);
			if (amIAWeekDay(ld.getDayOfWeek().toString()))
				workingDays--;
		}
		String date = ld.toString();
		if (!date.contains(":"))
				date += " 00:00:00";
		return date;
	}

	public static String formatDate(String processString, String format) {		
		try {
			LocalDate datetime = LocalDate.parse(processString, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
			processString = datetime.format(DateTimeFormatter.ofPattern(format));
			return processString;
		} catch (Exception e) {
			log.info(1);
		}
		return "1";
		
	}
	
	public static boolean isValidDate(String inDate) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss:ms");
        dateFormat.setLenient(false);
        try {
            dateFormat.parse(inDate.trim());
        } catch (ParseException pe) {
            return false;
        }
        return true;
    }
	
}