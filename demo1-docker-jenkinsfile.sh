echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> start Clearing old docker containers >>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
if docker ps -a | grep "demo1*" | awk '{print $1}' | xargs docker rm -f; then
    printf 'Clearing old containers done succeeded\n'
else
    printf 'Clearing old containers failed\n'
fi
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> finished Clearing old docker containers >>>>>>>>>>>>>>>>>>>>>>>>>>>>>"


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> start Clearing old docker images >>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
if docker images -a | grep "khalednoh*" | awk '{print $1":"$2}' | xargs docker rmi -f; then
    printf 'Clearing old images succeeded\n'
else
    printf 'Clearing old images failed\n'
fi
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Finished Clearing old docker images >>>>>>>>>>>>>>>>>>>>>>>>>>>>>"



echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> start building new docker images >>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
docker build -t khalednoh/demo1:demo1-0.0.1-SNAPSHOT$BUILD_NUMBER --pull=true $WORKSPACE
cat $JENKINS_HOME'/my_password.txt' | docker login --username khalednoh --password-stdin
docker push khalednoh/demo1:demo1-0.0.1-SNAPSHOT$BUILD_NUMBER
docker logout
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> finished building new docker images >>>>>>>>>>>>>>>>>>>>>>>>>>>>>"


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> start running container of last created Image >>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
docker run -d -p 8090:8090 --name=demo1-0.0.1-SNAPSHOT$BUILD_NUMBER khalednoh/demo1:demo1-0.0.1-SNAPSHOT$BUILD_NUMBER
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> finished running container of last created Image >>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
