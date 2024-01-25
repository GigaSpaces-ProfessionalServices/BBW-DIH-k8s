FROM gigaspaces/smart-cache-enterprise:16.4.0
ADD ./OracleFeeder-BBW-DEMO.jar /opt/gigaspaces/bin/pu.jar

ENTRYPOINT ["/opt/entrypoint.sh"]
CMD ["host", "run-agent", "--auto"]
