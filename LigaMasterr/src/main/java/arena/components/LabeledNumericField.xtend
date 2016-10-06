package arena.components

import org.uqbar.arena.widgets.Container
import org.uqbar.arena.widgets.NumericField

class LabeledNumericField extends AbstractLabeledWidget {
	NumericField numericField

	new(Container container) {
		super(container)
		label.fontSize = 12
		numericField.fontSize = 10
	}

	override bindValueToProperty(String property) {
		numericField.bindValueToProperty(property)
		this
	}

	def bindEnabledToProperty(String property) {
		numericField.bindEnabledToProperty(property)
		this
	}

	override setWidth(int ancho) {
		numericField.width = ancho
		this
	}

	override createWidget(AbstractLabeledWidget widget) {
		numericField = new NumericField(this)
		this
	}
}
