module MyModule::EducationDAO {

    use aptos_framework::signer;
    use aptos_framework::coin;
    use aptos_framework::aptos_coin::AptosCoin;

    struct DAO has store, key {
        total_funds: u64,
    }

    public fun create_dao(creator: &signer) {
        let dao = DAO {
            total_funds: 0,
        };
        move_to(creator, dao);
    }

    public fun contribute(benefactor: &signer, dao_address: address, amount: u64) acquires DAO {
        let dao = borrow_global_mut<DAO>(dao_address);
        let donation = coin::withdraw<AptosCoin>(benefactor, amount);
        coin::deposit<AptosCoin>(dao_address, donation);
        dao.total_funds = dao.total_funds + amount;
    }
}
