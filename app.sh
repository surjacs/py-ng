#!/bin/bash

# Flask 应用程序文件名
APP_FILE="app.py"

# Flask 应用程序的进程ID文件名
PID_FILE="app.pid"

start() {
    # 启动 Flask 应用程序
    nohup python3 $APP_FILE > /dev/null 2>&1 &

    # 获取 Flask 应用程序的进程ID，并将其保存到 PID 文件中
    echo $! > $PID_FILE
    echo "Flask 应用程序已启动。"
}

stop() {
    # 检查是否存在 PID 文件
    if [ -f "$PID_FILE" ]; then
        # 从 PID 文件中读取 Flask 应用程序的进程ID
        PID=$(cat $PID_FILE)

        # 终止 Flask 应用程序的进程
        kill $PID

        # 删除 PID 文件
        rm $PID_FILE
        echo "Flask 应用程序已停止。"
    else
        echo "Flask 应用程序未启动，无需停止。"
    fi
}

# 根据参数执行相应的操作
case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart)
        stop
        start
        ;;
    *)
        echo "Usage: $0 {start|stop|restart}"
        exit 1
        ;;
esac

exit 0

