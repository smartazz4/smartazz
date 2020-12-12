/*This is a downloader used by succession_c, it accepts a file location and a file url.*/   
#include <curl/curl.h>



void downloader(const char *silent, const char* url, const char* file_name)
{
  CURL* downloader = curl_easy_init();

  curl_easy_setopt( downloader, CURLOPT_URL, url);

  FILE* file = fopen( file_name, "w");

  curl_easy_setopt(downloader, CURLOPT_WRITEDATA, file);
  curl_easy_setopt(downloader, CURLOPT_NOPROGRESS, silent);

  curl_easy_perform( downloader);

  curl_easy_cleanup( downloader );

  fclose(file);

}
