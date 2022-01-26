class Headers {
 var requestsHeaders;
 static final authHeaders = {
    "usertype": "vendor",
    "Content-Type": "application/json",
  };

 static reqHeaders(String accessToken) =>
      {"Content-Type": "application/json", "Authorization": accessToken};
}
