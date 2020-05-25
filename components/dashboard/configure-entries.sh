# Build config file

config_file=${SERVICES_GENERATED_CONFIG_DIR}/dashmachine/config.ini
mkdir -p ${SERVICES_GENERATED_CONFIG_DIR}/dashmachine

# Make sure destination compose file is empty and inject the base config in it
    : > ${config_file}
    cat ${COMPONENTS_DIR}/dashboard/config/base.ini >> ${config_file}
    echo "" >> ${config_file}

# Inject apps in config
if [ -f ${TEMP_DASHBOARD_ENTRIES} ]; then
    cat ${TEMP_DASHBOARD_ENTRIES} >> ${config_file}
fi
