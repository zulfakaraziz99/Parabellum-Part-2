// SPDX-License-Identifier: GPL-3.0

pragma solidity "0.8.6";

/**
 * @title Insert Data
 * @dev Store patient's data
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract Insert_data {

    address payable patient;

    uint256 public no_of_patient = 0;       //Initialize number of patient and doctor
    uint256 public no_of_doctor = 0;

    struct Data{                            // Constructor to build array from the prompted information
        uint id;
        string name;
        uint phoneNo;
        string location;
        string problem; 
        uint age;
        string doc;
        bool vacant;
        uint payment;
        string date;
        address payable patient;
    }
    
    mapping(uint => Data) public Data_by_id; //Store Data array into unique integer

     modifier notPatient(uint _index) {         //Check the access from whom
        require(msg.sender == Data_by_id[_index].patient, "Only patient can access this");
        _;
     }   

     modifier IsVacant(uint _index) {           //Check if the doctor is occupied
        require(Data_by_id[_index].vacant == true, "Doctor is currently with another patient.");
        _;
     }

    modifier enoughTx(uint _index) {            //Check if ether is enough
        require(msg.value >= uint(Data_by_id[_index].payment), "Not enough Ether in your wallet");
        _;
    }

    function addPatient(string memory _name, string memory _location, uint _phoneNo, string memory _problem, uint  _payment, 
    string memory _doc, uint age, string memory date) public { //Add the information into the Data_by_id array
        require(msg.sender != address(0));
        no_of_patient ++;
        no_of_doctor ++;
        bool _vacancy = true;
        Data_by_id[no_of_patient] = Data(no_of_patient,_name,_phoneNo,_location, _problem, age, _doc, _vacancy, _payment, date, payable (address(0)));
        Data_by_id[no_of_doctor] = Data(no_of_patient,_name,_phoneNo,_location, _problem, age, _doc, _vacancy, _payment, date, payable (address(0)));
        
    }
}