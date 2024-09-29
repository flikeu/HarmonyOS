import { common } from '@kit.AbilityKit';
import { distributedKVStore } from '@kit.ArkData';
import { BusinessError } from '@kit.BasicServicesKit';

type getData = string | number | boolean | Uint8Array | void

export class KVStoreTools {
  static kvStore: distributedKVStore.SingleKVStore | undefined = undefined;

  static init(context: common.UIAbilityContext) {
    let kvManager: distributedKVStore.KVManager | undefined = undefined;
    const kvManagerConfig: distributedKVStore.KVManagerConfig = {
      context: context,
      bundleName: 'com.example.homenyosapp'
    };
    try {
      // 创建KVManager实例
      kvManager = distributedKVStore.createKVManager(kvManagerConfig);
      console.info('Succeeded in creating KVManager.');
      // 继续创建获取数据库
      try {
        const options: distributedKVStore.Options = {
          createIfMissing: true,
          encrypt: false,
          backup: false,
          autoSync: false,
          // kvStoreType不填时，默认创建多设备协同数据库
          kvStoreType: distributedKVStore.KVStoreType.SINGLE_VERSION,
          // 多设备协同数据库：kvStoreType: distributedKVStore.KVStoreType.DEVICE_COLLABORATION,
          securityLevel: distributedKVStore.SecurityLevel.S1
        };
        kvManager.getKVStore<distributedKVStore.SingleKVStore>('storeId', options,
          (err, store: distributedKVStore.SingleKVStore) => {
            if (err) {
              console.error(`Failed to get KVStore: Code:${err.code},message:${err.message}`);
              return;
            }
            console.info('Succeeded in getting KVStore.');
            KVStoreTools.kvStore = store;
            // 请确保获取到键值数据库实例后，再进行相关数据操作
          });
      } catch (e) {
        let error = e as BusinessError;
        console.error(`An unexpected error occurred. Code:${error.code},message:${error.message}`);
      }
    } catch (e) {
      let error = e as BusinessError;
      console.error(`Failed to create KVManager. Code:${error.code},message:${error.message}`);
    }
  }

  static set(key: string, value: string) {
    try {
      KVStoreTools.kvStore?.put(key, value, (err) => {
        if (err !== undefined) {
          console.error(`Failed to put data. Code:${err.code},message:${err.message}`);
          return;
        }
        console.info(`Succeeded in putting data key:${key} value:${value}`);
      });
    } catch (e) {
      let error = e as BusinessError;
      console.error(`An unexpected error occurred. Code:${error.code},message:${error.message}`);
    }
  }

  static get(key: string,cb:(data:getData)=>void) {
    return KVStoreTools.kvStore?.get(key, (err, data) => {
      if (err != undefined) {
        console.error(`Failed to get data. Code:${err.code},message:${err.message}`);
        return;
      }
      cb(data)
      console.info(`Succeeded in getting data. Data:${data}`);
    });
  }

  static remove(key: string,) {
    KVStoreTools.kvStore?.delete(key, (err) => {
      if (err !== undefined) {
        console.error(`Failed to delete data. Code:${err.code},message:${err.message}`);
        return;
      }
      console.info('Succeeded in deleting data.');
    });
  }
}