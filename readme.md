# Foundry Basics

Foundry, a powerful framework for Ethereum smart contract development, includes four main tools:

1. **Forge**: 
   - Primary command-line interface (CLI) tool for Ethereum smart contracts in Solidity
   - Designed for compiling, testing, and deploying contracts
   - Emphasizes speed and efficiency
   - Simplifies smart contract development and management for developers

2. **Anvil**: 
   - Local Ethereum testnet node in Foundry
   - Designed for smart contract testing in a local environment
   - Simulates an Ethereum network on your machine
   - Enables contract deployment and interaction without a live blockchain

3. **Cast**:
   - Interact with Ethereum contracts and networks
   - Perform contract calls, transactions, and chain data retrieval
   - Versatile for Ethereum RPC interactions

4. **Chisel**: 
   - Solidity REPL for testing and experimenting
   - Works on local or forked networks
   - Convenient for isolated code testing


# Detailed example usage of the tools

1. Forge
   - Initialize a project in Forge with `forge init`. Example: `forge init my_project` creates a project directory
   - Compile contracts using `forge build`. Compiles all Solidity files in "src" directory
   - Execute tests with `forge test`. This command runs all test files in the test directory
      - Filter the tests using `–match-contract`, `–match-test`, `–match-path`, and their inverse versions `--no-match-contract` and `--no-match-test`
      - Control verbosity with the `-v` flag. Increase verbosity by adding more v's upto `-vvvvv`
   - Deploy smart contracts to a blockchain using `forge create`. This requires specifying the contract and network details. For example, `forge create --rpc-url <RPC_ENDPOINT> --private-key <PRIVATE_KEY> src/MyContract.sol:MyContract`


2. Anvil
   - Start Anvil local node with `anvil` command. Launches a local Ethereum node on `http://localhost:8545`
   - Provides accounts and private keys for testing


3. Cast
   - Fetch current block number, block details, or address balances. Example: `cast block-number` retrieves current block number from default Ethereum network
   - Use Cast for sending Ether transactions. Helpful for testing contract interactions with Ether transfers. Example: `cast send --to 0xRecipientAddress --value 1ETH --private-key <YourPrivateKey>` sends 1 ETH to a specified address
   - Interacts with smart contract functions. Example: `cast call <ContractAddress> 'functionName(argType1,argType2)' [argValues]` to call a deployed contract's function
   - Perform Ethereum RPC calls. Example: `cast rpc eth_blockNumber` fetches the current block number using RPC
   - Encodes function call data, which is necessary when sending transactions to smart contracts.. Example: `cast encode 'functionName(argType1,argType2)' [argValues]` for encoding data for contract function call
   - It can decode data, such as transaction input data or logs, which is helpful for understanding contract interactions. Example: `cast decode <ABI> <Data>` can decode data based on a contract's ABI
   - Cast helps in converting cryptocurrency units, like Wei to Ether. Example: `cast from-wei 1000000000000000000` would convert Wei to Ether.
   - Can perform hashing and other cryptographic functions. Example: `cast keccak "some data"` would return the keccak-256 hash of the input data
   - Can be used to sign messages and verify signatures. Example: `cast sign <Message> --private-key <YourPrivateKey>` signs a message.


4. Chisel
   - Start Chisel by typing `chisel` and write Solidity code and receive verbose feedback
   - Can be used inside or outside a Foundry project. Inherits project configuration options if executed within a project root
   - For available commands, type "!help" within the REPL.


# Forge in-depth

## Writing Tests
- **Test Language:** Tests are written in Solidity, the same language used for smart contract development.
- **Test Execution:** Tests are executed using the Forge command `forge test`.
- **Test Structure:**
    - Tests are typically placed in a `test/` directory.
    - Test files have the `.t.sol` extension.
    - Test functions start with the word `test`.
- **Test Library:**
    - The Forge Standard Library's `Test` contract provides useful testing functions and assertions.
    - Import it using `import "forge-std/Test.sol";`.
- **Test Visibility:** Test functions must be declared as either `external` or `public`.
- **Test Lifecycle:**
    - `setUp()` function (optional): Runs before each test case to set up initial conditions.
    - `test_...()` functions: Individual test cases that assert expected behavior.
    - `testFail_...()` functions: Test cases that expect a function to revert.
- **Test Filtering:** Filter the tests using `–match-contract`, `–match-test`, `–match-path`, and their inverse versions `--no-match-contract` and `--no-match-test`
- **Test Verbosity:** Control verbosity with the `-v` flag. Increase verbosity by adding more v's upto `-vvvvv`
- **Test Deployment:** Tests are deployed to a specific address (`0xb4c79daB8f259C7Aee6E5b2Aa729821864227e84`) for isolation.
- **Best Practices:**
    - Use clear and descriptive test names.
    - Test for both expected behavior and error conditions.
    - Organize tests logically.
    - Consider using cheatcodes like `expectRevert` for controlled testing.


## Cheatcodes

**Purpose:**

- Cheatcodes are special functions designed to enhance testing capabilities within Foundry.
- They go beyond simple output testing and allow you to manipulate blockchain state, test for specific reverts and events, and more.

**Access:**

- Invoked by calling designated functions on a specific address: `0x7109709ECfa91a80626fF3989D68f67F5b1DD12D`.
- Easily accessed through the `vm` instance within the Forge Standard Library's `Test` contract.

**Common Cheatcodes:**

- **Manipulating State:**
   - **setBlockNumber(uint256 blockNumber):** Sets the current block number to a specific value, allowing you to test time-dependent logic.
   - **vm.prank(address sender):** Temporarily changes the message sender for the next call, allowing you to impersonate different accounts and simulate varied user interactions.
   - **vm.startPrank(address sender):** Initiates a prank that persists across multiple calls, affecting all subsequent calls until explicitly disabled.
   - **vm.stopPrank():** Terminates an active prank, reverting the message sender to its original state.
   - **vm.changePrank(address sender):** Modifies the sender for an ongoing prank, allowing for dynamic adjustments during test execution.

   - **setSender(address sender):** Sets the message sender for the next call, enabling you to simulate interactions from different accounts.
   - **setBalance(address target, uint256 balance):** Sets the balance of a specified address, useful for testing scenarios involving token transfers or financial interactions.

- **Testing Reverts:**
   - **expectRevert(string reason):** Asserts that the next call will revert with a specific error message, ensuring your code handles errors gracefully.

- **Mocking Data:**
   - **mockCall(address target, bytes calldata):** Mocks a call to another contract, returning pre-defined data instead of executing the actual contract code. This is helpful for isolating tests and controlling external dependencies.

- **Retrieving Information:**
   - **getCode(string calldata):** Returns the creation bytecode of a contract, allowing you to inspect its logic and verify its integrity.

- **Other Cheatcodes:**
   - **setChainId(uint256 chainId):** Sets the chain ID, useful for testing across different networks.
   - **setTimestamp(uint256 timestamp):** Sets the timestamp, enabling you to simulate time-based events.
   - **selfdestruct(address recipient):** Destroys the current contract, similar to the Solidity `selfdestruct` function.



**Importance in Testing:**

- Cheatcodes provide powerful tools for crafting comprehensive and robust smart contract tests.
- They enable you to simulate various blockchain conditions and edge cases that would be difficult or impossible to reproduce in a real environment.

**For more details and examples, refer to the full page on the Foundry Book website.**
