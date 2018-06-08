echo "Configuring and building SSM_LinearArray ROS package ..."

cd ROS/SSM_LinearArray/
mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
make -j 1
cd ../../../
