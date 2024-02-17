import os
import requests
from flask import Flask, request, jsonify

app = Flask(__name__)

# 设置全局代理
os.environ['HTTP_PROXY'] = 'http://127.0.0.1:101'
os.environ['HTTPS_PROXY'] = 'http://127.0.0.1:101'

@app.route('/cad103', methods=['GET', 'POST'])
def proxy():
    #url = request.args.get('url')
    url = 'http://127.0.0.1'
    if not url:
        return jsonify({'error': 'URL参数缺失'}), 400

    method = request.method.lower()
    headers = dict(request.headers)
    data = request.data

    try:
        # 发送HTTP请求到目标URL
        response = requests.request(method, url, headers=headers, data=data)

        # 返回目标URL的响应内容
        #return jsonify({
        #    'status_code': response.status_code,
        #    'headers': dict(response.headers),
        #    'content': response.text
        #})
        return response.text

    except Exception as e:
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True)

