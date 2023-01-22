from flask import Flask

app = Flask(__name__)

@app.route('/')
def main():
	return 'Consegui :D!'

@app.route('/health')
def health():
	return 'Tudo certo por aqui'

if __name__ == '__main__':
	app.run(host='0.0.0.0', port=8001)
