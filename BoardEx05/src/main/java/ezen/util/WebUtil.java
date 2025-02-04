package ezen.util;

public class WebUtil
{
	public static String replace(String text)
	{
		String html = text;
		
		html = html.replace("<", "&lt;");
		html = html.replace(">", "&gt;");
		html = html.replace("\n", "<br>");
		
		return html;
	}
}
