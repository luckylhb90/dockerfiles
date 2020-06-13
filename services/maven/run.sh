#!/bin/bash
echo "GIT_URL:${GIT_URL}"
echo "BRANCH:${BRANCH}"
echo "VM_OPTIONS:${VM_OPTIONS}"
#设置Maven堆栈大小
export MAVEN_OPTS="-Xmx1024m"
echo "MAVEN_OPTS:${MAVEN_OPTS}"

OUTPUT_ROOT=/usr/src/app/ins-mobile/$BRANCH/modules/aoede/target/ins-mobile-aoede-1.0.0
BOOTSTRAPCLASS="cn.xyz.server.bootstrap.EmbedTomcatAoedeWebServer"

if [ ! -d $BRANCH ]; then
  #拉取代码
  git clone -b $BRANCH $GIT_URL $BRANCH
  #编译项目
  cd $BRANCH && mvn clean install package -Dmaven.test.skip=true
  #启动应用
  java ${VM_OPTIONS} -classpath ${OUTPUT_ROOT}/WEB-INF/classes:${OUTPUT_ROOT}/WEB-INF/lib/* ${BOOTSTRAPCLASS}
else
  #拉取代码
  cd $BRANCH && git pull
  #编译项目
  cd $BRANCH && mvn clean install package -Dmaven.test.skip=true
  #启动应用
  java ${VM_OPTIONS} -classpath ${OUTPUT_ROOT}/WEB-INF/classes:${OUTPUT_ROOT}/WEB-INF/lib/* ${BOOTSTRAPCLASS}
fi
