package me.justshare.webapp.tags;

/**
 * User: filippo@diotalevi.com
 * Date: Nov 18, 2010
 */
public class Prettify {

    public static String prettify(String text)
    {
        text = handleUrls(text);
        text = handleCrs(text);
        return text;
    }

    public static String shortify(String text, int chars)
    {
        text = makeSureIsNotNull(text);
        return text.length() > chars ? text.substring(0, chars-3) + "..." : text;
    }

    private static String handleCrs(String text) {
        text = makeSureIsNotNull(text);
        return text.replaceAll("\n", "<br/>");
    }

    private static String handleUrls(String text) {
        text = makeSureIsNotNull(text);
        String[] tokens = text.split("[ +|,|\n+)]");

        for (int i = 0; i < tokens.length; i++)
        {
            String token = tokens[i];
            if (isAnURL(token))
            {
                if (token.endsWith("."))    //handle special case of full stop after the url, that cannot be treated easily with regex
                    token = token.substring(0, token.length() -1);

                text = text.replaceAll(buildRegex(token), "<a target='_new' href='"+token+"'>"+token+"</a>");
            }
        }
        return text;
    }

    private static String buildRegex(String token) {
        token = token.replaceAll("\\?", "\\\\?");
        token = token.replaceAll("\\+", "\\\\+");
        return token;
    }

    private static boolean isAnURL(String token) {
        return (token.startsWith("http://") || token.startsWith("https://"));
    }

    private static String makeSureIsNotNull(String text) {
        return text != null? text : "";
    }
    
    
}
