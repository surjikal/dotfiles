#!/usr/bin/env zsh

SPARK_HOME="${SPARK_HOME:-"/usr/local/opt/apache-spark/libexec"}"
HADOOP_HOME="${HADOOP_HOME:-"/usr/local/opt/hadoop/libexec"}"
HADOOP_CONF_DIR="${HADOOP_CONF_DIR:-"$HADOOP_HOME/etc/hadoop"}"

export HADOOP_OPTS="$HADOOP_OPTS -Djava.library.path=/usr/local/hadoop/lib/"

[[ ! -d "$SPARK_HOME" ]] && exit
[[ -d "$HADOOP_HOME" ]] && export HADOOP_HOME


alias spark="PYSPARK_DRIVER_PYTHON=ipython pyspark";
alias nb="env PYSPARK_DRIVER_PYTHON=jupyter PYSPARK_DRIVER_PYTHON_OPTS=notebook pyspark"

export PYTHONPATH="${PYTHONPATH}:${SPARK_HOME}/python/"
export PYTHONPATH="${PYTHONPATH}:$(find ${SPARK_HOME}/python/lib -name "py4j*" | head -n1)"
export SPARK_HOME

# Setup spark-env.sh
SPARK_ENV="$SPARK_HOME/conf/spark-env.sh"
cat <<EOF > $SPARK_ENV
#!/usr/bin/env bash

HADOOP_HOME=$HADOOP_HOME
HADOOP_CONF_DIR=$HADOOP_CONF_DIR
JAVA_HOME="\$(/usr/libexec/java_home -v11)"
EOF
