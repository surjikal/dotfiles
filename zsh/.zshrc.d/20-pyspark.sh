#!/usr/bin/env zsh
# shellcheck shell=bash

SPARK_HOME="${SPARK_HOME:-"/usr/local/opt/apache-spark/libexec"}"
HADOOP_HOME="${HADOOP_HOME:-"/usr/local/opt/hadoop/libexec"}"
HADOOP_CONF_DIR="${HADOOP_CONF_DIR:-"$HADOOP_HOME/etc/hadoop"}"

export HADOOP_OPTS="$HADOOP_OPTS -Djava.library.path=/usr/local/hadoop/lib/"

[[ ! -d "$SPARK_HOME" ]] && exit
[[ -d "$HADOOP_HOME" ]] && export HADOOP_HOME

function spark_version {
    grep '^Spark' "$SPARK_HOME/RELEASE" | head -n1 | cut -f2 -d' '
    # This works well, but is slower. Disabling for now.
    # if is_installed brew; then
    #     brew info --json apache-spark | jq -r '.[].linked_keg' | head -n1
    # fi
    # echo "3.1.1"
}

function spark_avro_package {
    echo "org.apache.spark:spark-avro_2.12:$(spark_version)"
}

function spark {
    PYSPARK_PYTHON="$(which python)" \
    PYSPARK_DRIVER_PYTHON=ipython \
    SPARK_HOME="$SPARK_HOME" \
        pyspark \
        "$@"
    # --conf "spark.jars.packages=$(spark_avro_package)"
}

function spark-nb {
    PYSPARK_PYTHON="$(which python)" \
    PYSPARK_DRIVER_PYTHON=jupyter \
    PYSPARK_DRIVER_PYTHON_OPTS=notebook \
    SPARK_HOME="$SPARK_HOME" \
        pipenv run pyspark \
        "$@"
}

PYTHONPATH="${PYTHONPATH}:${SPARK_HOME}/python/"
PYTHONPATH="${PYTHONPATH}:${SPARK_HOME}/python/lib/py4j"

export PYTHONPATH
export SPARK_HOME

# Setup spark-env.sh
SPARK_ENV="$SPARK_HOME/conf/spark-env.sh"
cat <<EOF >"$SPARK_ENV"
#!/usr/bin/env bash

HADOOP_HOME=$HADOOP_HOME
HADOOP_CONF_DIR=$HADOOP_CONF_DIR
JAVA_HOME="\$(/usr/libexec/java_home -v11)"
EOF
