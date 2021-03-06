package org.gbif.ipt.utils;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.Reader;
import java.io.UnsupportedEncodingException;
import java.io.Writer;
import java.text.NumberFormat;

import com.google.common.base.Preconditions;
import org.apache.log4j.Logger;

public class FileUtils {

  public static final String UTF8 = "UTF8";

  private static final Logger LOG = Logger.getLogger(FileUtils.class);

  private static final int BUFFER_SIZE = 8192;


  private FileUtils() {
    // private constructor.
  }

  public static void copyStreams(InputStream in, OutputStream out) throws IOException {
    // write the file to the file specified
    int bytesRead;
    byte[] buffer = new byte[BUFFER_SIZE];

    while ((bytesRead = in.read(buffer, 0, BUFFER_SIZE)) != -1) {
      out.write(buffer, 0, bytesRead);
    }

    out.close();
    in.close();
  }

  public static void copyStreamToFile(InputStream in, File out) throws IOException {
    copyStreams(in, new FileOutputStream(out));
  }

  public static String formatSize(long longSize, int decimalPos) {
    NumberFormat fmt = NumberFormat.getNumberInstance();
    if (decimalPos >= 0) {
      fmt.setMaximumFractionDigits(decimalPos);
    }
    double val = longSize / (1024f * 1024f);
    if (val > 1) {
      return fmt.format(val) + " MB";
    }
    val = longSize / 1024f;
    if (val > 1) {
      return fmt.format(val) + " KB";
    }
    return longSize + " bytes";
  }

  public static Reader getUtf8Reader(File file) throws FileNotFoundException {
    Reader reader = null;
    try {
      reader = new BufferedReader(new InputStreamReader(new FileInputStream(file), UTF8));
    } catch (UnsupportedEncodingException e) {
      e.printStackTrace();
    }
    return reader;
  }

  public static Writer startNewUtf8File(File file) throws IOException {
    try {
      org.apache.commons.io.FileUtils.touch(file);
    } catch (IOException e) {
      // io error can happen on windows if last modification cannot be set
      // see http://commons.apache.org/io/api-1.4/org/apache/commons/io/FileUtils.html#touch(java.io.File)
      // we catch this and check if the file was created
      if (file.exists() && file.canWrite()) {
        LOG.warn("Cant touch file, but it was created: " + e.getMessage());
        LOG.debug(e);
      } else {
        throw e;
      }
    }
    return new BufferedWriter(new OutputStreamWriter(new FileOutputStream(file, false), UTF8));
  }

  /**
   * Construct filename for persisted file (e.g. vocabulary or extension) replacing certain characters with an
   * underscore, and appending a suffix.
   *
   * @param name   original name, excluding suffix
   * @param suffix suffix to add to filename
   *
   * @return constructed filename
   */
  public static String getSuffixedFileName(String name, String suffix) {
    Preconditions.checkNotNull(name);
    Preconditions.checkNotNull(suffix);
    return name.replaceAll("[/.:]+", "_") + suffix;
  }

}
