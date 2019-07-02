
package main

import (
	"encoding/json"
	"fmt"

	"github.com/hyperledger/fabric/core/chaincode/shim"
	pb "github.com/hyperledger/fabric/protos/peer"
)

var _MAIN_LOGGER = shim.NewLogger("BaseSmartContractMain")

type SmartContract struct {
}

// Init initializes chaincode.
func (sc *SmartContract) Init(stub shim.ChaincodeStubInterface) pb.Response {
	_MAIN_LOGGER.Infof("Inside the init method ")

	return shim.Success(nil)
}
func (sc *SmartContract) probe(stub shim.ChaincodeStubInterface) pb.Response {
	ts := ""
	_MAIN_LOGGER.Info("Inside probe method")
	tst, err := stub.GetTxTimestamp()
	if err == nil {
		ts = tst.String()
	}
	output := "{\"status\":\"Success\",\"ts\" : \"" + ts + "\" }"
	_MAIN_LOGGER.Info("Retuning " + output)
	return shim.Success([]byte(output))
}

func (sc *SmartContract) save(stub shim.ChaincodeStubInterface) pb.Response {
	_, args := stub.GetFunctionAndParameters()
	if len(args) < 2 {
		return shim.Error("Invalid number of arguments")
	}
	key := args[0]
	value := args[1]
	txID := stub.GetTxID()
	dataToStore := map[string]string{
		"value":  value,
		"trxnId": txID,
		"id":     key,
	}
	jsonBytesToStore, _ := json.Marshal(dataToStore)
	stub.PutState(key, jsonBytesToStore)

	return shim.Success([]byte(jsonBytesToStore))
}
func (sc *SmartContract) saveKV(stub shim.ChaincodeStubInterface) pb.Response {
	_, args := stub.GetFunctionAndParameters()
	if len(args) < 1 {
		return shim.Error("Invalid number of arguments")
	}
	inputJSON := args[0]
	kvList := make([]map[string]string, 0)
	err := json.Unmarshal([]byte(inputJSON), &kvList)
	if err != nil {
		return shim.Error("Can not convert input JSON to valid input")
	}
	if len(kvList) == 0 {
		return shim.Error("Empty data provided")
	}
	for _, kv := range kvList {
		key := kv["key"]
		value := kv["value"]
		txID := stub.GetTxID()
		dataToStore := map[string]string{
			"value":  value,
			"trxnId": txID,
			"id":     key,
		}
		jsonBytesToStore, _ := json.Marshal(dataToStore)
		stub.PutState(key, jsonBytesToStore)
	}

	return shim.Success([]byte(fmt.Sprintf("%d records saved", len(kvList))))
}
func (sc *SmartContract) query(stub shim.ChaincodeStubInterface) pb.Response {
	fun, args := stub.GetFunctionAndParameters()
	if len(args) < 1 {
		return shim.Error("Invalid number of arguments")
	}
        if fun=="query"
       {
	key := args[0]
	data, err := stub.GetState(key)
	if err != nil {
		return shim.Success(nil)

	}
        return shim.Success(data)
      }
       else if fun=="gethistory"
       {
       if len(args) < 1 {
		return shim.Error("Incorrect number of arguments. Expecting 1")
	}

	Name := args[0]

	fmt.Printf("- start getHistoryForname: %s\n", Name)

	resultsIterator, err := stub.GetHistoryForKey(Name)
	if err != nil {
		return shim.Error(err.Error())
	}
	defer resultsIterator.Close()

	// buffer is a JSON array containing historic values for the marble
	var buffer bytes.Buffer
	buffer.WriteString("[")

	bArrayMemberAlreadyWritten := false
	for resultsIterator.HasNext() {
		response, err := resultsIterator.Next()
		if err != nil {
			return shim.Error(err.Error())
		}
		// Add a comma before array members, suppress it for the first array member
		if bArrayMemberAlreadyWritten == true {
			buffer.WriteString(",")
		}
		buffer.WriteString("{\"TxId\":")
		buffer.WriteString("\"")
		buffer.WriteString(response.TxId)
		buffer.WriteString("\"")

		buffer.WriteString(", \"Value\":")
		// if it was a delete operation on given key, then we need to set the
		//corresponding value null. Else, we will write the response.Value
		//as-is (as the Value itself a JSON marble)
		if response.IsDelete {
			buffer.WriteString("null")
		} else {
			buffer.WriteString(string(response.Value))
		}

		

		buffer.WriteString("}")
		bArrayMemberAlreadyWritten = true
	}
	buffer.WriteString("]")

	fmt.Printf("- getHistoryForname returning:\n%s\n", buffer.String())

	return shim.Success(buffer.Bytes())
        }

	
}

//Invoke is the entry point for any transaction
func (sc *SmartContract) Invoke(stub shim.ChaincodeStubInterface) pb.Response {
	var response pb.Response
	action, _ := stub.GetFunctionAndParameters()
	switch action {
	case "probe":
		response = sc.probe(stub)
	case "save":
		response = sc.save(stub)
	case "saveKV":
		response = sc.saveKV(stub)
	case "query":
		response = sc.query(stub)
	default:
		response = shim.Error("Invalid action provoided")
	}
	return response
}

func main() {
	err := shim.Start(new(SmartContract))
	if err != nil {
		_MAIN_LOGGER.Criticalf("Error starting  chaincode: %v", err)
	}
}


