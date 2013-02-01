package restx.factory;

import com.google.common.base.Optional;
import com.google.common.collect.Sets;
import org.junit.Test;

import java.util.Set;

import static org.hamcrest.CoreMatchers.equalTo;
import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.MatcherAssert.assertThat;

/**
 * User: xavierhanin
 * Date: 1/31/13
 * Time: 7:11 PM
 */
public class FactoryTest {

    @Test
    public void should_build_new_component_from_single_machine() throws Exception {
        Factory factory = Factory.builder().addMachine(new SingleNameFactoryMachine<String>(
                0, Name.of(String.class, "test"), BoundlessComponentBox.FACTORY) {
            @Override
            protected String doNewComponent(Factory factory) {
                return "value1";
            }
        }).build();

        Optional<NamedComponent<String>> component = factory.getNamedComponent(Name.of(String.class, "test"));

        assertThat(component.isPresent(), equalTo(true));
        assertThat(component.get().getName(), equalTo(Name.of(String.class, "test")));
        assertThat(component.get().getComponent(), equalTo("value1"));

        assertThat(factory.getNamedComponent(Name.of(String.class, "test")).get(), is(component.get()));
    }


    @Test
    public void should_build_component_lists_from_multiple_machines() throws Exception {
        Factory factory = Factory.builder()
                .addMachine(new SingleNameFactoryMachine<String>(
                        0, Name.of(String.class, "test 1"), BoundlessComponentBox.FACTORY) {
                    @Override
                    protected String doNewComponent(Factory factory) {
                        return "value 1";
                    }
                })
                .addMachine(new SingleNameFactoryMachine<String>(
                        0, Name.of(String.class, "test 2"), BoundlessComponentBox.FACTORY) {
                    @Override
                    protected String doNewComponent(Factory factory) {
                        return "value 2";
                    }
                })
                .build();

        Set<NamedComponent<String>> components = factory.getNamedComponents(String.class);

        Set<NamedComponent<String>> expected = Sets.newHashSet(
                NamedComponent.of(String.class, "test 1", "value 1"),
                NamedComponent.of(String.class, "test 2", "value 2"));
        assertThat(components, equalTo(expected));
    }
}
