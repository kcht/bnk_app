class StrengthMeter extends React.Component {
    render() {
        return (
            <ReactBootstrap.Panel>
                <RulesProgressBar {...this.props} />
                <h4>A good password:</h4>
                <RulesList {...this.props}/>
            </ReactBootstrap.Panel>
        )
    }
}