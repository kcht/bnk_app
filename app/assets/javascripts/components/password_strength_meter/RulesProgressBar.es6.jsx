class RulesProgressBar extends React.Component {
    satisfiedPercent(){
        let { rules, password } = this.props

        let satisfiedCount = rules
            .map(rule => rule.predicate(password))
            .reduce((count, satisfied) => count + (satisfied ? 1: 0), 0)

        let rulesCount = rules.length

        return (satisfiedCount/ rulesCount) * 100.0
    }

    progressColor() {
        let percentage = this.satisfiedPercent()
        return classNames({
            danger: (percentage < 33.4),
            warning: (percentage >=33.4 && percentage < 66.7),
            success: (percentage >= 66.7)
        })
    }

    render() {
        return (<ReactBootstrap.ProgressBar now={this.satisfiedPercent()}
                                            bsStyle={this.progressColor()}/>
        )
    }
}