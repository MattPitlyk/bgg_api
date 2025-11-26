import 'package:bgg_api/src/http.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:test/test.dart';

void main() {
  group('BggHttp Auth', () {
    test('should send Authorization header when token is provided', () async {
      final token = 'my-secret-token';
      final mockClient = MockClient((request) async {
        expect(request.headers['Authorization'], equals('Bearer $token'));
        return Response('<root></root>', 200);
      });

      final bggHttp = BggHttp(http: mockClient, token: token);
      await bggHttp.get(['thing']);
    });

    test('should not send Authorization header when token is not provided', () async {
      final mockClient = MockClient((request) async {
        expect(request.headers.containsKey('Authorization'), isFalse);
        return Response('<root></root>', 200);
      });

      final bggHttp = BggHttp(http: mockClient);
      await bggHttp.get(['thing']);
    });
  });
}
