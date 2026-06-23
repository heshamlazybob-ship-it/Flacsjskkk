FROM python:3.10-slim

# تثبيت متصفح كروم الرسمي داخل السيرفر
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    curl \
    unzip \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list' \
    && apt-get update && apt-get install -y google-chrome-stable \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# تثبيت المكتبات (تأكد أن سيلينيوم مكتوب داخل requirements.txt)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# أمر تشغيل ملف البايثون الخاص بك (استبدل main.py باسم ملفك)
CMD ["python", "main.py"]
