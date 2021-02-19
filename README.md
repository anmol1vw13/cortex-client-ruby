# Cortex Client
[![Build Status] (https://github.com/anmol1vw13/cortex-client-ruby/workflows/Push%20Cortex%20Client/badge.svg?branch=master)]

## About
It is a ruby library to push timeseries metrics to cortex.

## Prerequisites
ruby - 2.5.0

## Usage
#### Step1: Configure the client

```
CortexClient.configure do |config|
   config.host = '<host>'
   config.metrics_push_api_path = '<metrics-api>'
   config.token = "sample_token"
end
```
#### Step2: Push a timeseries based metric

```
metric = CortexClient::Metric.new('test_usage')
response = metric.
     add_label(name: "label1", value: "value1").
     add_label(name: "label2", value: "value2").add_sample(value: 1).push

The metric instance has the error appended if there's any and if there's no error, then the instance 
has a prom_message in it.
```
