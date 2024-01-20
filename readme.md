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

## Testing
- Execute tests with `forge test`. This command runs all test files in the test directory
- Filter the tests using `–match-contract`, `–match-test`, `–match-path`, and their inverse versions `--no-match-contract` and `--no-match-test`
- Control verbosity with the `-v` flag. Increase verbosity by adding more v's upto `-vvvvv`