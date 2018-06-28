FROM ros:indigo-perception
RUN apt-get update && apt-get install -y \
	python-catkin-pkg python-rosdep python-wstool \
	python-catkin-tools ros-indigo-catkin \
	&& rm -rf /var/lib/apt/lists

ENV CATKIN_WS=/root/catkin_ws
RUN rm /bin/sh \
	&& ln -s /bin/bash /bin/sh
	
# Prerequisites

# https://github.com/stevenlovegrove/Pangolin

RUN apt-get update && apt-get install -y \
	libglew-dev	cmake libpython2.7-dev build-essential g++ \
	&& rm -rf /var/lib/apt/lists	

RUN git clone https://github.com/stevenlovegrove/Pangolin.git \
	&& cd Pangolin \
	&& mkdir build \
	&& cd build \
	&& cmake .. \
	&& cmake --build .

# Eigen3, BLAS, LAPACK, csparse

RUN apt-get update && apt-get install -y \
	libeigen3-dev libblas-dev liblapack-dev \
	libsuitesparse-dev python-matplotlib \
	&& rm -rf /var/lib/apt/lists	
		
# Installation

RUN git clone https://github.com/ICRA2017/SSM_LinearArray.git

RUN cd SSM_LinearArray && ./build.sh

RUN cd SSM_LinearArray && chmod a+x build_ROS.sh

RUN source /opt/ros/indigo/setup.bash && export ROS_PACKAGE_PATH=/SSM_LinearArray/ROS:$ROS_PACKAGE_PATH \
	&& cd SSM_LinearArray && ./build_ROS.sh
