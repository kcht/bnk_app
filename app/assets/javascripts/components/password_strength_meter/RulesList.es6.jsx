class RulesList extends React.Component {
    isRuleSatisfied(rule) {
        let {password} = this.props
        return rule.predicate(password)
    }

    ruleClass(rule) {
        let satisfied = this.isRuleSatisfied(rule);

        return classNames({
            ["text-success"]: satisfied,
            ["text-danger"]: !satisfied
        })
    }

    render(){
        let {rules} = this.props
        return(
            <ul>
                {rules.map(rule =>
                    <li className={this.ruleClass(rule)}>
                        {rule.label}
                    </li>
                )}
            </ul>
        )
    }
}