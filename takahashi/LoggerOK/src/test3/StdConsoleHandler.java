package test3;

import java.io.IOException;
import java.util.logging.LogManager;
import java.util.logging.Logger;
import java.util.logging.StreamHandler;

public class StdConsoleHandler extends StreamHandler {
	{
		setOutputStream(System.out);
	}

	public static void main(String[] args) {

		try {
			LogManager.getLogManager().readConfiguration(
					StdConsoleHandler.class.getResourceAsStream("customLogging.properties"));
		} catch (SecurityException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

		Logger loggerX = Logger.getLogger("xxx");
		Logger loggerY = Logger.getLogger("xxx.yyy");
		Logger loggerZ = Logger.getLogger("xxx.zzz");

		loggerX.severe("-----X---------------------------------------------------------");
		loggerX.fine("テストfine");
		loggerX.info("テストinfo");
		loggerX.severe("テストsevere");

		loggerY.severe("-----Y---------------------------------------------------------");
		loggerY.fine("テストfine");
		loggerY.info("テストinfo");
		loggerY.severe("テストsevere");

		loggerZ.severe("-----Z---------------------------------------------------------");
		loggerZ.fine("テストfine"); //ここに注目して実行
		loggerZ.info("テストinfo");
		loggerZ.severe("テストsevere");

	}
}