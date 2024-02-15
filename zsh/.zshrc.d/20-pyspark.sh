#!/usr/bin/env zsh
# shellcheck shell=bash

SPARK_HOME="${SPARK_HOME:-"$HOMEBREW_PREFIX/opt/apache-spark/libexec"}"

if [[ -d "${HADOOP_HOME:-}" ]]; then
    export HADOOP_HOME="${HADOOP_HOME:-"$HOMEBREW_PREFIX/opt/hadoop/libexec"}"
    export HADOOP_CONF_DIR="${HADOOP_CONF_DIR:-"$HADOOP_HOME/etc/hadoop"}"
    export HADOOP_OPTS="$HADOOP_OPTS -Djava.library.path=/usr/local/hadoop/lib/"
fi

[[ ! -d "$SPARK_HOME" ]] && return

# PYTHONPATH="${PYTHONPATH:-}:${SPARK_HOME}/python"
# PYTHONPATH="${PYTHONPATH:-}:${SPARK_HOME}/python/lib"
# export PYTHONPATH
export SPARK_HOME

function spark_version {
    grep '^Spark' "$SPARK_HOME/RELEASE" | head -n1 | cut -f2 -d' '
}
alias spark-version="spark_version"

function _spark_package_avro {
    echo "org.apache.spark:spark-avro_2.12:$(spark_version)"
}

function _spark_package_hudi {
    echo "org.apache.hudi:hudi-spark3-bundle_2.12:0.13.1"
}

function _spark_package_bigquery {
    echo "com.google.cloud.spark:spark-bigquery-with-dependencies_2.12:0.34.0"
}

function _spark_packages {
    echo "$(_spark_package_avro),$(_spark_package_hudi),$(_spark_package_bigquery)"
}
function spark {
    PYSPARK_PYTHON="$(which python)" \
    PYSPARK_DRIVER_PYTHON=ipython \
    SPARK_HOME="$SPARK_HOME" \
        poetry run pyspark \
        --jars "jars/local/gcs-connector-latest-hadoop2.jar" \
        --conf "spark.jars.packages=$(_spark_packages)" \
        --conf 'spark.serializer=org.apache.spark.serializer.KryoSerializer' \
        --conf 'spark.sql.catalog.spark_catalog=org.apache.spark.sql.hudi.catalog.HoodieCatalog' \
        --conf 'spark.sql.extensions=org.apache.spark.sql.hudi.HoodieSparkSessionExtension' \
        "$@"
}

function spark-notebook {
    PYSPARK_PYTHON="$(which python)" \
    PYSPARK_DRIVER_PYTHON=jupyter \
    PYSPARK_DRIVER_PYTHON_OPTS=notebook \
    SPARK_HOME="$SPARK_HOME" \
        poetry run pyspark \
        --jars "jars/local/gcs-connector-latest-hadoop2.jar" \
        --conf "spark.jars.packages=$(_spark_packages)" \
        --conf 'spark.serializer=org.apache.spark.serializer.KryoSerializer' \
        --conf 'spark.sql.catalog.spark_catalog=org.apache.spark.sql.hudi.catalog.HoodieCatalog' \
        --conf 'spark.sql.extensions=org.apache.spark.sql.hudi.HoodieSparkSessionExtension' \
        "$@"
}

# For spark-dashboard
# INFLUXDB_ENDPOINT=$(hostname)
# export INFLUXDB_ENDPOINT

# Setup spark-env.sh
# SPARK_ENV="$SPARK_HOME/conf/spark-env.sh"
# cat <<EOF >"$SPARK_ENV"
# #!/usr/bin/env bash

# # HADOOP_HOME=$HADOOP_HOME
# # HADOOP_CONF_DIR=$HADOOP_CONF_DIR
# JAVA_HOME="$JAVA_HOME"
# EOF
