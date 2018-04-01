//同じ階層にあるpropertiesを参照にHandlerを定義する方法

package test2;

import java.io.IOException;
import java.util.logging.LogManager;
import java.util.logging.Logger;
import java.util.logging.StreamHandler;

public class StdConsoleHandler extends StreamHandler{
	{
		setOutputStream(System.out);
	}

	public static void main(String[] args) {

		try {
			LogManager.getLogManager().readConfiguration(
					StdConsoleHandler.class.getResourceAsStream("customLogging.properties"));
		}catch(SecurityException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

		Logger logger = Logger.getLogger(Logger.GLOBAL_LOGGER_NAME);

		logger.fine("テストfine");
		logger.info("テストconfig");
		logger.severe("テストsevere");

	}
}