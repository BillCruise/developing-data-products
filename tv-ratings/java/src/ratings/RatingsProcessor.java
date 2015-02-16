package ratings;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.util.Scanner;

public class RatingsProcessor {

    /**
     * @param args
     */
    public static void main(String[] args) {
        String inFile = "resources/tv.ratings.dat";
        String outFile = "resources/tv.ratings";
        
        try {
            File file = new File(inFile);
            Scanner scanner = new Scanner(file);
            
            PrintWriter writer = new PrintWriter(outFile);
            writer.println("Series\tVotes\tRating\tTitle\tSeason\tEpisode");
            
            while (scanner.hasNext()) {
                String line = scanner.nextLine();
                String newDist = line.substring(0, 17); // discard
                
                String voteStr = line.substring(17, 25).trim();
                String rankStr = line.substring(25, 32).trim();
                
                int votes = Integer.parseInt(voteStr);
                double rating = Double.parseDouble(rankStr);
                
                String title = line.substring(32);
                // System.out.println(title);
                
                int lCurlyIndex = title.indexOf("{");
                int rCurlyIndex = title.indexOf("}");
                
                String episodeInfo = title.substring(lCurlyIndex+1, rCurlyIndex);
                int lParenIndex = episodeInfo.indexOf("(#");
                int rParenIndex = episodeInfo.indexOf(")", lParenIndex);
                
                String seriesTitle = title.substring(1, lCurlyIndex).trim();
                seriesTitle = seriesTitle.replaceAll("\"", "");
                String episodeName = episodeInfo.substring(0, lParenIndex).trim();
                
                String seasonInfo = episodeInfo.substring(lParenIndex+1, rParenIndex);
                int dotIndex = seasonInfo.indexOf(".");
                
                String seasonStr = seasonInfo.substring(1, dotIndex);
                String episodeStr = seasonInfo.substring(dotIndex+1);
                
                int seasonNum = Integer.parseInt(seasonStr);
                int episodeNum = Integer.parseInt(episodeStr);
                
                Episode ep = new Episode(seriesTitle, episodeName, votes, rating, seasonNum, episodeNum);
                
                writer.println(ep.toString());
            }
            
            scanner.close();
            writer.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
    }
    
    
}

class Episode {
    String seriesTitle;
    String episodeTitle;
    int votes;
    double rating;
    int season;
    int episode;
    
    public Episode(String seriesTitle, String episodeTitle, int votes, double rating, int season, int episode) {
        this.seriesTitle = seriesTitle;
        this.episodeTitle = episodeTitle;
        this.votes = votes;
        this.rating = rating;
        this.season = season;
        this.episode = episode;
    }
    
    public String toString() {
        return String.format("%s\t%d\t%.1f\t%s\t%d\t%d", 
                seriesTitle, votes, rating, episodeTitle, season, episode);
    }
}
