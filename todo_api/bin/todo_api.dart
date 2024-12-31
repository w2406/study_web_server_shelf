import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

void main(List<String> arguments) async {
  // リクエストを処理するハンドラー追加
  // ミドルウェア追加
  final handler = const Pipeline().addMiddleware(logRequests()).addHandler(_echoRequest);

  // サーバ起動
  var server = await shelf_io.serve(handler, 'localhost', 8080);

  // コンテンツ圧縮機能ON(レスポンス速度が上がる)
  server.autoCompress = true;

  // サーバ起動メッセージ
  print('Serving at http://${server.address.host}:${server.port}');
}

// リクエストを処理するハンドラー
Response _echoRequest(Request request) => Response.ok('Request for "${request.url}"');
