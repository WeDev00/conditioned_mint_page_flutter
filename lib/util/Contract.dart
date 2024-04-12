
import 'package:flutter_web3_provider/ethers.dart';

final myInstance = await EthersProvider.onReady;
final signer = myInstance.getSigner();
final contract = Contract(deployedContractAddress, signer);