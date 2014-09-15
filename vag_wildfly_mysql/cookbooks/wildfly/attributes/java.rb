# encoding: UTF-8
# rubocop:disable LineLength
#
# Copyright (C) 2014 Brian Dwyer - Intelligent Digital Services
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# => Java Configuration
    default['java']['install_flavor'] = 'oracle'
    default['java']['oracle']['accept_oracle_download_terms'] = true
    default['java']['jdk_version'] = '7'
    default['java']['jdk']['7']['x86_64']['url'] = 'http://download.oracle.com/otn-pub/java/jdk/7u60-b19/jdk-7u60-linux-x64.tar.gz'
    default['java']['jdk']['7']['x86_64']['checksum'] = 'c7232b717573b057dbe828d937ee406b7a75fbc6aba7f1de98a049cbd42c6ae8'
