import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;

class PushNotificationService {
  static Future<String> getAccessToken() async {
    final serviceAccountJson = {
      "type": "service_account",
      "project_id": "md-brew-crew-3a97e",
      "private_key_id": "a6aabb540b75d5435c82a5c534993f1ef09cea9b",
      "private_key": """-----BEGIN PRIVATE KEY-----
MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC0ocHRnWdS0DU9
l8jjuIMAt93GDaMIU38CHT9RWYW6uTc8Ef1JbgU9BThV8O66IHXdQU3ob3qusvfh
3QAVVb8BKoRPbiZQIm4pAf6T8hrO3uG5x5uk8Nux+yvxuOZDFacn2Khe/Rzxp4d2
IE7AG6wY8+SOF+aLexbZVsdzYBrENnVre58GQ6XZFAwAB2S+zHCFxVfIGsG5egS6
d/pI7Q3qYcncjJUkOIjj7zlk0R7Dc+TSohD+kT3XYRYhgRkEaFT5DzUW7STd7Ogn
7WZsTApzODGw9L/7TdUh49+5j51CZ9C8TuqWHtXPpq7Uy/rPxsomA5V8kNdKYKx3
1GL/MnehAgMBAAECggEAHgFSx2WswLJqbalVixJe3JMuaVRhlSP9kJXYK0TCNKLI
vJdGali20QyZb5k+prd2rMLI1MgT6oo7KA9EkMa2HFT6NpGXFq+pefFlXyET9/JJ
L8mrHqqN7BJLmfM7eMBTjIhua50DHldUZrh2LG5MV7bH7BynRNs1D/Rc3FsGBzq3
DCcuesiOzWPHrbmjaEKR1GVEI+Qlv+/8qWeir8QZ1hU7+6IubU2Ql4+lpIYWcygA
A8o18LcMklaSir0TrZx8EBh63urvzQuLVis1p7i1+/jvcOcpzon13iGXHXymTfHE
bCJy29Y6wE6JZOU72++KR3NJJuubrH5j6Qtp93qr+QKBgQDlyCX+DPOLxONRtzEX
x2W/ys50DQxNi+W3UEIA4ZdlJIxZvpq75LYyeLavwJAEbvYLeUaZ2bD3szeoXK3d
WFiPZyycA+yGaubz6mX+M+BxfHCLcZndXYJ1KyuxqURxI5H22Ji2Wb2c99XuKJCv
WW/KqSqjx4jFZSm1AmshDPxAbQKBgQDJPfRRsVHaDDp8JSIic/lskmXto4LE7YSU
fhwO4yLgHKOYePIAA3Z9ASw1+E33ZGmlMmkZUcpo40qTlgPXX+o/t/GZ/mVOfFnK
A3Tnl81AgbLjKvb5qx8Rd6G0iNC+mG5+E3l2yhTOin164XqppikjU0hSgNhF0J0e
oABqAc+bhQKBgQCXYnKtWokF93QwPPnqCaNeZVX5HTOSz21LhWPGwtmEeDzDT5EP
4xGqVN8/ESWQ1i3hx0edSs+NkZREprKhVngaGkZIj0lAEaQQ5MfHXxQqkGpxZCmT
ruypFwUVakg+Jcofj/mkgaErjhhybGVOMSU2ppcCCg5wxkJhD7PWtYBnTQKBgCJu
bDfx+8wv3W3SOKXma92Mqs3e9QfWj6GMdiaB7DymCcOTpewkq4g1xCezxTs3ve+a
0WqYmOYbRW4884lNCto+EaNEaHbmRcKPltftHBwWVNITTtBm29j0PAGUiwqhL/54
PIb7ilXQUinNHFycZlt561zaWKaRS+CqhYedqbS1AoGAJGun8Yx4BFKLcpVS1AxB
mM5vMA92xcYlSA/zD93XXXC25x6dnngeUMCD3ppOCuNVpf+Fj/qd+0qRTKtLXO3N
Tl9KbudUxC4iVzhsvKkCYnrZ5RwXe7mOdrWavuiz47fw8/3UZ/7uiNpe20EKNcsv
FjmVhCLQv+ArMD22cmsLcrU=
-----END PRIVATE KEY-----\n""",
      "client_email": "brew-crew@md-brew-crew-3a97e.iam.gserviceaccount.com",
      "client_id": "108053017297669416476",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/brew-crew%40md-brew-crew-3a97e.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    };

    List<String> scopes = [
      "https://www.googleapis.com/auth/firebase.messaging",
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
    ];

    auth.ServiceAccountCredentials credentials = auth.ServiceAccountCredentials.fromJson(serviceAccountJson);

    final client = await auth.clientViaServiceAccount(credentials, scopes);
    final accessToken = (await client.credentials.accessToken).data;

    client.close();

    return accessToken;
  }

  static sendNotificationToSelectedDriver(BuildContext context) async {
    final String serverAccessToken = await getAccessToken();
    String endpointFirebaseCloudMessaging = "https://fcm.googleapis.com/v1/projects/md-brew-crew-3a97e/messages:send";

    final Map<String, dynamic> message = {
      'message': {
        'token': await getAccessToken(),  // replace with actual device token
        'notification': {
          'title': "Sign In Successful",
          'body': "Welcome back!",
        },
        'data': {
          'uid': "c90ev5w7ZZchUbniNjIpOscURoY2",  // replace with actual user ID
        }
      }
    };

    final http.Response response = await http.post(
      Uri.parse(endpointFirebaseCloudMessaging),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $serverAccessToken',
      },
      body: jsonEncode(message),
    );

    if (response.statusCode == 200) {
      print("Notification sent successfully.");
    } else {
      print("Failed to send notification. Status code: ${response.statusCode}");
      print("Response body: ${response.body}");
    }
  }
}
