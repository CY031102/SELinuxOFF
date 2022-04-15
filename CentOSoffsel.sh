menu(){
    echo "这个是关闭CentOS7 SELinux的一键脚本"
    echo "1. 关闭SELinux"
    echo "0. 退出脚本"
    read -n2 -p "请输入选项：" menuChoose
    case ${menuChoose} in
        1) shutselfire ;;
        0) exit 0
    esac
}

shutselfire(){
	check=`sestatus | grep "dis"`
	if [[ $check ]]
	then
		echo "SELinux未启动"
	else
		echo "检测SELunix开启，开始执行关闭"
		echo "系统会在3秒后开始关闭SELunix，使用Ctrl+C取消"
		#sleep-for-3-seconds_等待3秒
		sleep 3s
		sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
		sed -i 's/SELINUXTYPE=targeted/#SELINUXTYPE=targeted/g' /etc/selinux/config
		#reboot_重启
		echo "The system will reboot in 5 seconds, press Ctrl+C to cancel"
		sleep 5s
		reboot
	fi
}

menu
