function go_ros() {
  if [ -f "/etc/fedora-release" ]; then
    echo "You on Fedora mate. Doing nothing!"
  else
    export ROS_PYTHON_VERSION=3
    source /opt/ros/noetic/setup.zsh
  fi
}

function go_ros2() {
  export ROS_VERSION=2
  # export ROS_DOMAIN_ID=42
  export ROS_PYTHON_VERSION=3
  if [ -f "./install/setup.zsh" ]; then
    echo "There is a local install sourcing it"
    source ./install/setup.zsh
  elif [ -f "/etc/fedora-release" ]; then
    echo "Trying to source fedora ros2"
    source /usr/lib64/ros2-humble/setup.zsh
    # source /usr/lib64/ros2-jazzy/setup.zsh
  else
    echo "Trying to soure humble"
    source /opt/ros/humble/setup.zsh
  fi

  python3 -c "
import platform, os
print()
print('System:', platform.system(), platform.release())
print('Python:', platform.python_implementation(), platform.python_version())
print('   RMW:', os.environ.get('RMW_IMPLEMENTATION','?'))
print('   ROS:', os.environ.get('ROS_DISTRO','distro?'))
print('🤖 Welcome to ROS on', platform.node())
print()
"
}
